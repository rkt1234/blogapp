import 'package:blogapp/provider/create_provider.dart';
import 'package:blogapp/services/navigation_service.dart';
import 'package:blogapp/services/toast_service.dart';
import 'package:blogapp/utils/configs.dart';
import 'package:blogapp/utils/text_style.dart';
import 'package:blogapp/widgets/custom_blog_textfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CreateBlog extends StatefulWidget {
  final token;
  const CreateBlog({super.key, this.token});

  @override
  State<CreateBlog> createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  late TextEditingController titleController = TextEditingController();
  late TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateProvider>(builder: (context, provider, child) {
      return PopScope(
        onPopInvoked: (didPop) {
          if (didPop) {
            provider.resetPickedImage();
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text("New Post", style: TextStyle(fontWeight: FontWeight.w900),),
            centerTitle: true,
            automaticallyImplyLeading: false,
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await provider.pickImage();
                        },
                        child: provider.pickedImage == null
                            ? Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                height: 300,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(6)),
                                width: double.infinity,
                                child: const Icon(
                                  Icons.add_a_photo,
                                  color: Colors.black45,
                                ),
                              )
                            : Container(
                                margin: const EdgeInsets.symmetric(horizontal: 16),
                                height: 300,
                                width: double.infinity,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image.file(
                                    provider.pickedImage!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10)),
                        child: BlogCustomTextField(
                          errorText: provider.titleError,
                          controller: titleController,
                          labelText: 'Title',
                          labelStyle: blogTitleStyle,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 300,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10)),
                        child: BlogCustomTextField(
                          errorText: provider.descriptionError,
                          controller: descriptionController,
                          labelText: 'Description',
                          labelStyle: blogDescriptionStyle,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {
                            DateTime now = DateTime.now();
                            String createdTime =
                                DateFormat('M/d/yyyy h:mm a').format(now);
                            print("hahahahah");
                            print(imageUrl);
                            bool navigate = await provider.checkValidity(
                              titleController.text,
                              descriptionController.text,
                              createdTime,
                              uId,
                              widget.token,
                              userName,
                              imageUrl,
                            );
                            getToast(
                                context, provider.toastMessage, provider.icon);
                            if (navigate) {
                              pop(context);
                              provider.pickedImage = null;
                            }
                          },
                          style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: const Color(0xFF1A80E5), // Button text color
                                      
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(12), // Rounded corners
                          ),
                          elevation: 2, // Button elevation
                          textStyle: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                          child:   Text(
                            "Publish",
                            style: GoogleFonts.lato(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              provider.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(),
            ],
          ),
        ),
      );
    });
  }
}

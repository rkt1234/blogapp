import 'package:blogapp/provider/create_provider.dart';
import 'package:blogapp/services/navigation_service.dart';
import 'package:blogapp/services/toast_service.dart';
import 'package:blogapp/utils/configs.dart';
import 'package:blogapp/utils/text_style.dart';
import 'package:blogapp/widgets/custom_blog_textfield.dart';
import 'package:flutter/material.dart';
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
            appBar:
                AppBar(title: const Text("Create a new blog"), centerTitle: true, automaticallyImplyLeading: false,),
            body: Stack(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                            onTap: () async {
                                await provider.pickImage();
                              },
                            child: provider.pickedImage == null
                            ?  Container(
                                  child:  Icon(
                                  Icons.add_a_photo,
                                  color: Colors.black45,
                                ),
                                  margin: const EdgeInsets.symmetric(horizontal: 16),
                                  height: 170,
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(6)),
                                  width: MediaQuery.of(context).size.width,
                                ):Container(
                                margin: EdgeInsets.symmetric(horizontal: 16),
                                height: 170,
                                width: MediaQuery.of(context).size.width,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child:Image.file(
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
                            border: Border.all(color: Colors.red),
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
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.red),
                              borderRadius: BorderRadius.circular(10)),
                          child: BlogCustomTextField(
                            errorText: provider.descriptionError,
                            controller: descriptionController,
                            labelText: 'Description',
                            labelStyle: blogDescriptionStyle,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
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
                              imageUrl);
                          getToast(context, provider.toastMessage, provider.icon);
                          if (navigate) {
                           
                            pop(
                              context,
                            );
                             provider.pickedImage = null;
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue, // Button text color
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(12), // Rounded corners
                          ),
                          elevation: 5, // Button elevation
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        child: const Text("create"),
                      )
                    ],
                  ),
                ),
                provider.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container()
              ],
            )),
      );
    });
  }
}

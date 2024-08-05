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
      return Scaffold(
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
                    SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: ClipRRect(
                        child: Image.network(
                            fit: BoxFit.cover,
                            "https://media.gettyimages.com/id/1492656400/photo/chennai-india-mahendra-singh-dhoni-of-chennai-super-kings-catches-their-helmet-whilst.jpg?s=612x612&w=gi&k=20&c=JbYno-lPxLLeKkCy4sa9TYJ1IMPDFMNVO0VF1xgqYCM="),
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
                            'imageUrl',
                            uId,
                            widget.token,
                            userName,
                            imageUrl);
                        getToast(context, provider.toastMessage, provider.icon);
                        if (navigate) {
                          pop(
                            context,
                          );
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
          ));
    });
  }
}

import 'package:blogapp/provider/edit_provider.dart';
import 'package:blogapp/services/navigation_service.dart';
import 'package:blogapp/services/toast_service.dart';
import 'package:blogapp/utils/configs.dart';
import 'package:blogapp/utils/text_style.dart';
import 'package:blogapp/widgets/custom_blog_textfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditBlogScrren extends StatefulWidget {
  String title;
  String description;
  String blogImageUrl;
  String token;
  late int postId;
  EditBlogScrren(
      {super.key,
      required this.title,
      required this.description,
      required this.blogImageUrl,
      required this.token,
      required this.postId});

  @override
  State<EditBlogScrren> createState() => _EditBlogScrrenState();
}

class _EditBlogScrrenState extends State<EditBlogScrren> {
  late TextEditingController titleController = TextEditingController();
  late TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.title;
    descriptionController.text = widget.description;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EditProvider>(
      builder: (context, provider, child) {
        return PopScope(
          onPopInvoked: (didPop) {
            provider.resetPickedImage();
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text("Edit your blog"),
              centerTitle: true,
              automaticallyImplyLeading: false,
            ),
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await provider.pickImage();
                          },
                          child: provider.pickedImage == null
                              ? Container(
                                  margin: EdgeInsets.symmetric(horizontal: 16),
                                  height: 300,
                                  width: MediaQuery.of(context).size.width,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: Image.network(
                                      widget.blogImageUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : Container(
                                  margin: EdgeInsets.symmetric(horizontal: 16),
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
                          height: 200,
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
                        ElevatedButton(
                          onPressed: () async {
                            DateTime now = DateTime.now();
                            String createdTime =
                                DateFormat('M/d/yyyy h:mm a').format(now);
                            print("hahahahah");
                            print(imageUrl);
                            bool navigate = await provider.checkValidity(
                              widget.blogImageUrl,
                              titleController.text,
                              descriptionController.text,
                              createdTime,
                              uId,
                              widget.token,
                              userName,
                              imageUrl,
                              widget.postId,
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
                          child: const Text("Update"),
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
      },
    );
  }
}

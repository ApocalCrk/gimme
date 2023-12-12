// ignore_for_file: non_constant_identifier_names, prefer_final_fields
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:gimme/constants.dart';
import 'package:gimme/screens/workout/workout_components/detail_exercise.dart';
import 'package:gimme/screens/workout/workout_components/slide_up_exercise.dart';
import 'package:shimmer/shimmer.dart';

class WorkoutDetail extends StatefulWidget {
  final int id_workout, total_time, total_exercise;
  final String image, description, workout_name, kalori, duration;
  final List data;
  const WorkoutDetail(
      {super.key,
      required this.total_exercise,
      required this.image,
      required this.description,
      required this.id_workout,
      required this.workout_name,
      required this.total_time,
      required this.data,
      required this.duration,
      required this.kalori});

  @override
  State<WorkoutDetail> createState() => _WorkoutDetailState();
}

class _WorkoutDetailState extends State<WorkoutDetail> {
  double defaultContextSizeCut = 3;
  ScrollController _scrollController = ScrollController();

  void _scrollListener() {
    setState(() {
      if (_scrollController.offset <= 0) {
        defaultContextSizeCut = 3;
      } else if (_scrollController.offset > 0 && _scrollController.offset < 100) {
        defaultContextSizeCut = 3 + (_scrollController.offset / 20);
      } 
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                child: ExtendedImage.network(
                  widget.image,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / defaultContextSizeCut,
                  fit: BoxFit.cover,
                  cache: true,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  loadStateChanged: (ExtendedImageState state) {
                    switch (state.extendedImageLoadState) {
                      case LoadState.loading:
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            height: MediaQuery.of(context).size.height / defaultContextSizeCut,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                          ),
                        );
                      case LoadState.completed:
                        return ExtendedRawImage(
                          image: state.extendedImageInfo?.image,
                          color: Colors.black.withOpacity(0.8),
                          colorBlendMode: BlendMode.darken,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / defaultContextSizeCut,
                          fit: BoxFit.cover,
                        );
                      case LoadState.failed:
                        return const Icon(Icons.error);
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      width: 50,
                      height: 50,
                      child: Center(
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_rounded),
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                    const Text(
                      "Detail Workout",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Montserrat",
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: secondaryColor.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.total_time.toString(),
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Montserrat",
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const Text(
                            'minutes',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Montserrat",
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          widget.workout_name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text(
                        widget.description,
                        style: const TextStyle(
                          color: secondaryColor,
                          fontFamily: "Montserrat",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 15.0),
                      child: Text(
                        "Exercise (${widget.total_exercise})",
                        style: const TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(0, -20),
                      child: ListView.separated(
                        separatorBuilder: (context, index) => const Divider(
                          color: Colors.transparent,
                          height: 10,
                        ),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.data.length,
                        itemBuilder: (context, index) {
                          var sendDataExercise = {};
                          sendDataExercise['id_workout'] = widget.id_workout;
                          sendDataExercise['exercise_name'] = widget.data[index]['name'];
                          sendDataExercise['description_excercise'] = widget.data[index]['description_excercise'];
                          sendDataExercise['kalori'] = widget.data[index]['kalori'];
                          sendDataExercise['set'] = widget.data[index]['set'];
                          sendDataExercise['duration'] = widget.data[index]['duration'];
                          var exerciseData = widget.data[index];
                          return InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (_) {
                                  return modalSlideUp(data: sendDataExercise);
                                },
                              );
                            },
                            child: Detail_Exercise(
                              image: exerciseData['image'],
                              exercise_name: exerciseData['name'],
                              time_exercise: int.parse(exerciseData['duration']),
                              kalori: exerciseData['kalori'],
                              duration: exerciseData['duration'],
                              id_workout: widget.id_workout
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


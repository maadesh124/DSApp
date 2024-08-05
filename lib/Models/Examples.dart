import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fp4/Models/Model.dart';
import 'Application.dart';
import 'CourseAttendance.dart';
import 'DrivingSchool.dart';
import 'Enquiry.dart';
import 'Learner.dart';
import 'Instructor.dart';
import 'Course.dart';
import 'Reviews.dart';
import 'SchoolAttendance.dart';
import 'Service.dart';
import 'Vehicle.dart';





class Examples
{


  static final DrivingSchool DRIVINGSCHOOL = DrivingSchool(
  schoolName: 'Safe Drive School',
  mobileNumber: 9876543210,
  email: 'contact@safedriveschool.com',
  location: '123 Main Street, Cityville',
  description: 'Providing quality driving lessons for over 20 years.',
  ownerName: 'John Doe',
  instructorIds: ['inst1', 'inst2', 'inst3'],
  courseIds: ['course1', 'course2'],
  serviceIds: ['service1', 'service2', 'service3'],
  vehicleIds: ['vehicle1', 'vehicle2'],
  enquiryIds: ['enquiry1', 'enquiry2'],
);


   static final Instructor INSTRUCTOR = Instructor(
    name: 'John Doe',
    insId: 'instructor123',
    mobileNumber: '9876543210',
    email: 'johndoe@example.com',
    joinDate1: DateTime(2023, 1, 1),
    salary: 50000.0,
    dob1: DateTime(1990, 1, 1),
    gender: 'Male',
    specialization: '4-wheeler driving',
    timeTable: {
      'Monday': 
      {   
          '13:23-14:56':'Scooty driving|c001',
          '09:00-10:00':'2-wheeler driving|avcdd32',
          '17:30-18:40':'4-wheeler driving|ertyu12'
      },
      'Tuesday': 
      {
          '9:34-10:32':'2-wheeler driving|avcdd32',
          '17:09-18:32':'4-wheeler driving|ertyu12'
      },
      'Thursday':
      {
        '10:45-11:50':'course1|c0001'
        
      }
    },
    schoolId:  "school789",
    courseIds: ['avcdd32', 'ertyu12'],
    serviceIds: ['serviceid1', 'serviceid2'],
    password: 'strongPassword',
  );

   static final Learner LEARNER = Learner(
    name: 'John Doe',
    mobileNumber: '1234567890',
    email: 'johndoe@example.com',
    dob1: DateTime(1990, 1, 1),
    address: '123 Main Street',
    gender: 'Male',
    courseObjectIds: ['course1', 'course2'],
    serviceObjectIds: ['service1', 'service2'],
  );

  static final Course CORURSE = Course(
    name: '2-wheeler driving',
    courseId: 'C001',
    startDate: DateTime(2023, 1, 1),
    endDate: DateTime(2023, 12, 31),
    courseDuration:'90 days',
    courseFee: 20000,
    startTime: TimeOfDay(hour: 9, minute: 0),
    endTime: TimeOfDay(hour: 12, minute: 0),
    totalSeats: 50,
    availableSeats: 45,
    courseDescription: '2-wheeler driving course description',
    instructorObjectId: 'instructor123',
    instructorName: 'John doe',
    instructorId: 'insid2',
    vehicleObjectId: 'vehicle123',
    vehicleNumber: 'tn10ap3423',
    progress: [
      Progress(lessonName: 'PreRequisites', lessonDescription: 'Pre requisites for course', isCompleted: true),
      Progress(lessonName: 'Introduction', lessonDescription: 'Basic concepts', isCompleted: false),
      Progress(lessonName: 'Lsson n',lessonDescription: '''lesson description lesson description 
      lesson description lesson description lesson description lesson description lesson description 
      lesson description lesson description ''',isCompleted: true)
      // ... other progress items
    ],
    learnerObjectIds: ['learner1', 'learner2'],
    applicationObjectIds: ['application1', 'application2'],
    enquiryObjectIds: ['enquiry1', 'enquiry2'],
    dsName: 'DSNAme',
    dsObjectId: 'dsobj1'

  );
 


 static final Service SERVICE = Service(
    name: 'FC Apply',
    fee: 10000,
    description: 'Vehicle Fitness Certificate',
    instructorId: 'instructor123',
    requiredDocuments: ['Driving License', 'Identity Proof'],
    studentObjectIds: ['student1', 'student2'],
    applicationObjectIds: ['application1', 'application2'],
    reviewObjectId: 'review123',
  );


 static final Vehicle VEHICLE = Vehicle(
  schoolId: 'schoolId',
    vehicleNumber: 'DL1CA1234',
    name: 'Car',
    // vehicleId: 'vehicle123',
    // numberOfCoursesUsing: 2,
    description: 'Vehicle Description',
    timeTable: {
      'Monday':
      {
          '9-10':'4-wheeler weekend|avcdd32',
          '17-18':'4-wheeler driving|ertyu12'
      },
      'Tuesday': 
      {
          '9-10':'4-wheeler weekend|avcdd32',
          '17-18':'4-wheeler driving|ertyu12'
      },
    }, // Example time table data
    courseObjectIds: ['course1', 'course2'],
  );
  
  static final SingleAttendance SINGLEATTENDANCE=SingleAttendance(name: 'Name1',id: 'id1',status: false);

  static final CourseAttendance COURSEATTENDANCE = CourseAttendance(
    courseName:'Course NAme',
    attendance:{
      '29|7|2024':
      [SingleAttendance(name: 'Name1',id: 'id1',status: false),
      SingleAttendance(name: 'Name2',id: 'id2',status: false),
      SingleAttendance(name: 'Name3',id: 'id3',status: false)
      ],
            '23|07|24':
      [SingleAttendance(name: 'Name1',id: 'id1',status: false),
      SingleAttendance(name: 'Name2',id: 'id2',status: false),
      SingleAttendance(name: 'Name3',id: 'id3',status: false)
      ]
    } 
  );

  // Adding attendance for a date


  static final SchoolAttendance SCHOOLATTENDANCE = SchoolAttendance(
    schoolId: 'school123',
    attendance:{
      '24|07|24':
      [SingleAttendance(name: 'Name1',id: 'id1',status: false),
      SingleAttendance(name: 'Name2',id: 'id2',status: false),
      SingleAttendance(name: 'Name3',id: 'id3',status: false)
      ],
            '23|07|24':
      [SingleAttendance(name: 'Name1',id: 'id1',status: false),
      SingleAttendance(name: 'Name2',id: 'id2',status: false),
      SingleAttendance(name: 'Name3',id: 'id3',status: false)
      ]
    } 
  );

static final Application APPLICATION = Application(
  learnerAddress: 'Adress ',
  learnerAge: 20,
  isMale: true,
    schoolId: 'shoolid1',
    serviceId: 'not applicable',
    courseName: '2 wheeler driving',
    learnerName: 'Learner Name',
    dateApplied: DateTime.now(),
    learnerObjectId: '3ls1508zatxqMzCx0VIY',
    applicationNumber: 'APP001',
    courseId: 'course123', // For course application
    // serviceId: 'service123', // For service application
  );


static final Enquiry ENQUIRY=Enquiry(
  learnerName: 'Learner name',
  learnerAge: 21,
  learnerAddress: '123 South street',
  isMale: true,
  enquiryNo: 'enqid12', 
learnerId: 'studid1', messages: [Message( message: 'Hello',
    dateTime: DateTime.now(),
    sender:Model.LEARNER,)
    ,Message(
    message: 'Message from school',
    dateTime: DateTime.now(),
    sender: Model.DRIVINGSCHOOL,
  )
    ]);



static final Review REVIEW=Review(
    receiver: 'Instructor',
    receiverId: 'instructor123',
    reviews: {
      'learnerid1': {
        'data': 'Great instructor!',
        'name': 'John Doe',
      },
      'learnerid2': {
        'data': 'Very helpful',
        'name': 'Jane Smith',
      },
    },
  );



}




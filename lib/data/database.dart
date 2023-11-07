import 'package:hive/hive.dart';

class ToDoDataBase {
  List toDoList = [];

  //reference books
  final _myBox = Hive.box('mybox');

  //run if first time opening EVER this app?
  void createInitialData() {
    //todo- add priority
    DateTime now = DateTime.now();
    toDoList = [
      [
        "Something I need to do", //title
        false, //completed
        now, //time created
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum', //description
        'high', //priority
        null, //time completed
      ],
      [
        "Something I did", //title
        true, //completed
        now, //time created
        'description', //description
        'low', //priority
        now, //time completed
      ],
      [
        "ewqewq",
        true,
        DateTime.parse("2023-11-07 19:20:12.129"),
        "",
        "high",
        DateTime.parse("2023-11-02 19:22:37.537"),
      ],
      [
        "ewqewq",
        true,
        DateTime.parse("2023-11-07 19:20:27.994"),
        "",
        "high",
        DateTime.parse("2023-11-06 19:22:38.905"),
      ],
      [
        "qwsdasagw",
        true,
        DateTime.parse("2023-11-07 19:20:32.013"),
        "",
        "high",
        DateTime.parse("2023-11-04 19:22:39.938"),
      ],
      [
        "sagvxzvsd",
        true,
        DateTime.parse("2023-11-07 19:20:35.037"),
        "",
        "high",
        DateTime.parse("2023-11-01 19:22:42.963"),
      ],
      [
        "savcdwqvew",
        true,
        DateTime.parse("2023-11-07 19:20:40.139"),
        "",
        "high",
        DateTime.parse("2023-11-06 19:22:48.585"),
      ],
      [
        "asdgdsag",
        true,
        DateTime.parse("2023-11-07 19:20:42.514"),
        "g",
        "high",
        DateTime.parse("2023-11-06 19:22:49.606"),
      ],
      [
        "adsfsad",
        true,
        DateTime.parse("2023-11-07 19:20:44.720"),
        "",
        "high",
        DateTime.parse("2023-11-02 19:22:51.117"),
      ],
      [
        "cvsvwdwq",
        true,
        DateTime.parse("2023-11-07 19:20:47.284"),
        "",
        "high",
        DateTime.parse("2023-11-03 19:22:53.467"),
      ],
      [
        "xcvxzv",
        true,
        DateTime.parse("2023-11-07 19:21:36.126"),
        "",
        "high",
        DateTime.parse("2023-11-07 19:22:54.761"),
      ],
      [
        "zxcvxz",
        true,
        DateTime.parse("2023-11-07 19:21:50.290"),
        "",
        "high",
        DateTime.parse("2023-11-06 19:22:56.496"),
      ],
      [
        "dsadas",
        true,
        DateTime.parse("2023-11-07 19:30:08.692"),
        "",
        "medium",
        DateTime.parse("2023-11-07 19:30:29.622")
      ],
      [
        "sdfasfe",
        true,
        DateTime.parse("2023-11-07 19:30:12.045"),
        "",
        "medium",
        DateTime.parse("2023-11-06 19:30:30.022")
      ],
      [
        "sdfeesa",
        true,
        DateTime.parse("2023-11-07 19:30:14.425"),
        "",
        "medium",
        DateTime.parse("2023-11-04 19:30:31.348")
      ],
      [
        "dsfzsde",
        true,
        DateTime.parse("2023-11-07 19:30:16.529"),
        "",
        "medium",
        DateTime.parse("2023-11-05 19:30:32.587")
      ],
      [
        "dsafsae",
        true,
        DateTime.parse("2023-11-07 19:30:18.335"),
        "",
        "medium",
        DateTime.parse("2023-11-01 19:30:33.252")
      ],
      [
        "xcvzsvdsa",
        true,
        DateTime.parse("2023-11-07 19:30:20.844"),
        "",
        "medium",
        DateTime.parse("2023-11-02 19:30:33.810")
      ],
      [
        "zxvxcve",
        true,
        DateTime.parse("2023-11-07 19:30:23.337"),
        "",
        "medium",
        DateTime.parse("2023-11-05 19:30:34.294")
      ],
      [
        "sdafxczvdswe",
        true,
        DateTime.parse("2023-11-07 19:30:26.298"),
        "",
        "medium",
        DateTime.parse("2023-11-01 19:30:34.838")
      ],
      [
        "dsdaDSA",
        true,
        DateTime.parse("2023-11-07 19:38:26.495"),
        "",
        "low",
        DateTime.parse("2023-11-07 19:38:40.368")
      ],
      [
        "ASDas",
        true,
        DateTime.parse("2023-11-07 19:38:28.568"),
        "",
        "low",
        DateTime.parse("2023-11-05 19:38:40.889")
      ],
      [
        "dfagasewf",
        true,
        DateTime.parse("2023-11-07 19:38:30.947"),
        "",
        "low",
        DateTime.parse("2023-11-04 19:38:41.415")
      ],
      [
        "sfgsd",
        true,
        DateTime.parse("2023-11-07 19:38:34.414"),
        "gds",
        "low",
        DateTime.parse("2023-11-05 19:38:41.960")
      ],
      [
        "sdfasddfewewfqfdsa",
        true,
        DateTime.parse("2023-11-07 19:38:38.012"),
        "",
        "low",
        DateTime.parse("2023-11-01 19:38:43.183")
      ],
      [
        "dsadsa",
        true,
        DateTime.parse("2023-11-07 19:38:50.492"),
        "",
        "low",
        DateTime.parse("2023-11-06 19:38:54.366")
      ],
      [
        "SAFDSA",
        true,
        DateTime.parse("2023-11-07 19:38:53.069"),
        "",
        "low",
        DateTime.parse("2023-11-01 19:38:54.783")
      ],
      [
        "FDSFDSA",
        true,
        DateTime.parse("2023-11-07 19:39:05.050"),
        "",
        "low",
        DateTime.parse("2023-11-04 19:39:06.395")
      ],
    ];
  }

  //load data from db
  void loadData() {
    toDoList = _myBox.get("TODOLIST");
  }

  //update data in Hive db
  void updateDataBase() {
    _myBox.put("TODOLIST", toDoList);
  }

  //search terms in title and description
  List search(String term) {
    return toDoList.where((task) {
      String title = task[0].toLowerCase();
      String description = task[3].toLowerCase();
      return title.contains(term.toLowerCase()) ||
          description.contains(term.toLowerCase());
    }).toList();
  }
}

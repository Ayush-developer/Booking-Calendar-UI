import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';


List<String> selectedCoaches=[];
double _containerHeight = 100;
bool isChecking = false;


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:CalendarScreen(),
    );
  }
}

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {

  DateTime _focusedDate = DateTime.now(); // this will display the current Month
  int _selectedDay = DateTime.now().day;  // this will display the day 
  List<String> _days = ['Mon','Tue','Wed','Thu','Fri','Sat'];
  



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Pick Your Slot',style: const TextStyle(
                      fontSize: 16,
    
                      fontFamily: 'IBMPlexSans',fontWeight: FontWeight.w500
                    ),),

      ),
      body:Column(
        children:[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 IconButton(
      onPressed: () {
        setState(() {
          _focusedDate = DateTime(
            _focusedDate.year,
            _focusedDate.month - 1,
            
          );
        });
      },
      icon: const Icon(Icons.arrow_left),
    ),
    Text('${_getMonthName(_focusedDate.month)} ${_focusedDate.year}'),
    IconButton(onPressed: (){setState(() {
      _focusedDate = DateTime(
        _focusedDate.year,
         _focusedDate.month+1,
         
         );
    });}, icon: const Icon(Icons.arrow_right)),
    
                ],

              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children:_days.map((day)=>
                Text(day,
               style: const TextStyle(
                      fontSize: 16,
    
                      fontFamily: 'IBMPlexSans',fontWeight: FontWeight.w500
                    ),
                )).toList()
              ),
              Expanded(child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7), itemCount:_daysInMonth(_focusedDate),
               itemBuilder:(context, index)  {
                final day = index+1;
                final isSelected = day==_selectedDay;
               

                return GestureDetector(
                  onTap:(){
                    setState((){
                      _selectedDay =day;
                      if(_selectedDay%2==0){
                        selectedCoaches= ['Coach1 ', 'Coach 2'];

                      }
                      else{
                        selectedCoaches=['Coach A','Coach B'];
                      }

                    });
                  },
                  child : Container(
                    margin: EdgeInsets.all(2),
                    decoration:BoxDecoration(
                      color:isSelected?Colors.blue:Colors.transparent,
                      borderRadius:BorderRadius.circular(10),

                    ),
                    alignment:Alignment.center,
                    child:Text(
                      '$day',
                      style:TextStyle(
                        color:isSelected?Colors.white:Colors.black,
                      )
                    )
                  )
                );
              },)),
              Expanded(child: ListView.builder(itemBuilder:(context,index){
                
                return CoachTimingsExpand(index: index);
              },itemCount: selectedCoaches.length,)),
              Container(
  margin: const EdgeInsets.all(16),
  width: double.infinity,
  child: ElevatedButton(
    onPressed: () {
      // Your submit logic here
    },
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 15), backgroundColor: Colors.blue.shade600,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ), // Button color
    ),
    child: Text(
      'Submit',
      style: const TextStyle(
                      fontSize: 16,
    
                      fontFamily: 'IBMPlexSans',fontWeight: FontWeight.w500,color:Colors.white
                    ),
    ),
  ),
)

        ]
      )
    );
  }
}

class CoachTimingsExpand extends StatefulWidget {
  final int index;
  const CoachTimingsExpand({super.key, required this.index});

  @override
  State<CoachTimingsExpand> createState() => _CoachTimingsExpandState();
}

class _CoachTimingsExpandState extends State<CoachTimingsExpand> {
  @override
  Widget build(BuildContext context) {
    return  Container(
  margin: const EdgeInsets.all(12),
  padding: const EdgeInsets.all(16),
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [Colors.white,Colors.white],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 8,
        offset: const Offset(2, 4),
      ),
    ],
  ),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            selectedCoaches[widget.index],
           style: const TextStyle(
                      fontSize: 16,
    
                      fontFamily: 'IBMPlexSans',fontWeight: FontWeight.w500
                    ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                isChecking = !isChecking;
                _containerHeight = isChecking ? 100 : 150;
              });
            },
            icon: Icon(
              isChecking ? Icons.arrow_downward : Icons.arrow_upward,
              color: Colors.black,
            ),
          ),
        ],
      ),
      const SizedBox(height: 8),
      if (!isChecking)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TimeSlotWidget(),
            TimeSlotWidget(),
            TimeSlotWidget(),
          ],
        ),
    ],
  ),
);



  }
}

class TimeSlotWidget extends StatefulWidget {
  @override
  _TimeSlotWidgetState createState() => _TimeSlotWidgetState();
}

class _TimeSlotWidgetState extends State<TimeSlotWidget> {
  bool isTapped = false; // Track the tapped state

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isTapped = !isTapped; // Toggle the tapped state
        });
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isTapped 
                ? [Colors.green.shade300, Colors.green.shade600] 
                : [Colors.blue.shade300, Colors.blue.shade600],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Text(
          "10:AM",
        style: const TextStyle(
                      fontSize: 16,
    
                      fontFamily: 'IBMPlexSans',fontWeight: FontWeight.w500,
                      color:Colors.white
                    ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}


String _getMonthName(int month){
  const months = ['January', 'February', 'March', 'April', 'May', 'June','July', 'August', 'September', 'October', 'November', 'December'];
  return months[month-1];
}

int _daysInMonth(DateTime date) {    //ai wala code
  final firstDayNextMonth = (date.month < 12)
      ? DateTime(date.year, date.month + 1, 1)
      : DateTime(date.year + 1, 1, 1);
  return firstDayNextMonth.subtract(const Duration(days: 1)).day;
}

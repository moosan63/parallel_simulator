//final int EXECUTING = 0;
//final int WAITING   = 1;
class Task{
  int task_size;
  int xpos;
  int ypos;
  int state;
  int assign_num;
  color this_color;
  Task(int x, int y,int size,int a, color c){
    task_size = size;
    xpos = x;
    ypos = y;
    state = WAITING;
    assign_num = a;
    this_color = c;
  }
  void draw(){
    if(state == WAITING|| state == EXECUTING){
      fill(this_color);
    }
    if(state == (FINISHED)){
      fill(0,0,255);
    }
    ellipse(xpos, ypos, task_size+3,task_size+3); 
  }
}

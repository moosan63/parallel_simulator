//direction
//final int STARVATION = 0;
//final int EATING     = 1;

class Worker{
  int init_xpos;
  int init_ypos;
  int xpos;
  int ypos;
  int state;
  int eating_count;
  int target_size;
  int assign_num;
  color this_color;
  Worker(int xp,int yp,int a,color c){
    xpos = xp;
    ypos = yp;
    init_xpos = xp;
    init_ypos = yp;
    state = STARVATION;
    eating_count = 0;
    assign_num = a;
    this_color = c;
  }
  
  void draw(){
    fill(this_color);
    ellipse(xpos, ypos, 10,10);
  }
}

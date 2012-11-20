//Constant
final int WIDTH  = 400;
final int HEIGHT = 300;
final int MAX_WORKER = 1;
final int MAX_TASK = 10;

//worker and task state
final int STARVATION = 0;
final int EATING     = 1;
final int EXECUTING  = 2;
final int WAITING    = 3;
final int FINISHED   = 4;
final int ASSIGN     = 5;
final int NON_ASSIGN = 6;
int TYPE = NON_ASSIGN;

color orange = color(255.0, 160.0, 0);
color yellow = color(255, 255, 0);
color pink   = color(255, 160, 255);
color aqua   = color(0, 255, 255);
color purple = color(255, 0, 255);


int timer = 0;
int flag=0;

int[][] MAP = new int[WIDTH][HEIGHT];
Worker[] worker = new Worker[MAX_WORKER];
Task[] task = new Task[10];

void setup() {
  //initialize
  size(WIDTH, HEIGHT);
  frameRate(5);
  for (int i =0;i<MAX_WORKER;i++) {
    if (TYPE == NON_ASSIGN) { 
      worker[i] = new Worker(i*35+35, 270, 0, orange);
    }
    else {
      if (i==0) {
        worker[i] = new Worker(i*35+35, 270, 0, orange);
      }
      else if (i==1) {        
        worker[i] = new Worker(i*35+35, 270, 1, yellow);
      }
      else if (i==2) {
        worker[i] = new Worker(i*35+35, 270, 2, pink);
      }
      else if (i==3) {
        worker[i] = new Worker(i*35+35, 270, 3, aqua);
      }
      else if (i==4) {
        worker[i] = new Worker(i*35+35, 270, 4, purple);
      }
    }
  }
  for (int i=0;i<MAX_TASK;i++) {
    if (TYPE == NON_ASSIGN) { 
      task[i] = new Task(i*35+35, 20, i+1, 0, orange);
    }
    else {
      if (i==0 || i==1) {
        task[i] = new Task(i*35+35, 20, i+1, 0, orange);
      }
      else if (i==2 || i==3) {
        task[i] = new Task(i*35+35, 20, i+1, 1, yellow);
      }
      else if (i==4 || i==5) {
        task[i] = new Task(i*35+35, 20, i+1, 2, pink);
      }
      else if (i==6 || i==7) {
        task[i] = new Task(i*35+35, 20, i+1, 3, aqua);
      }
      else if (i==8 || i==9) {
        task[i] = new Task(i*35+35, 20, i+1, 4, purple);
      }
    }
  }
}
void draw() {
  background(100);
  println(timer); 
  for (int i=0;i<MAX_WORKER;i++) {
    worker[i].draw();
  }

  for (int i=0;i<MAX_TASK;i++) {
    task[i].draw();
  }  
  //stop flag
  if (flag == 1) {    
    stop();
  }

  //eating
  for (int i=0; i<MAX_WORKER;i++) {
    if (worker[i].state == STARVATION) {
      for (int j=0;j<MAX_TASK;j++) {
        if (TYPE == NON_ASSIGN) {
          if (task[j].state == WAITING) {
            worker[i].xpos = task[j].xpos;
            worker[i].ypos = task[j].ypos+5;
            worker[i].state = EATING;
            worker[i].eating_count = 0;
            worker[i].target_size = j;
            task[j].state = EXECUTING;
            break;
          }
        }      
        else{
          if (task[j].state == WAITING && worker[i].assign_num == task[j].assign_num) {
            worker[i].xpos = task[j].xpos;
            worker[i].ypos = task[j].ypos+5;
            worker[i].state = EATING;
            worker[i].eating_count = 0;
            worker[i].target_size = j;
            task[j].state = EXECUTING;
            break;
          }        
        }
      }
    }
  }

  //finished eating check
  for (int i=0; i<MAX_WORKER;i++) {
    if (worker[i].state == EATING) {
      for (int j=0;j<MAX_TASK;j++) {
        if (TYPE == NON_ASSIGN) {
          if (task[j].state == EXECUTING && ( worker[i].target_size == j )) {
            if (worker[i].eating_count == task[j].task_size) {
              worker[i].xpos = worker[i].init_xpos;
              worker[i].ypos = worker[i].init_ypos;
              worker[i].state = STARVATION;
              task[j].state = FINISHED;
            }
            else {
              worker[i].eating_count++;
            }
          }
        }
        else { //ASSIGN
          if (task[j].state == EXECUTING && ( worker[i].assign_num == task[j].assign_num )) {
            if (worker[i].eating_count == task[j].task_size) {
              worker[i].xpos = worker[i].init_xpos;
              worker[i].ypos = worker[i].init_ypos;
              worker[i].state = STARVATION;
              task[j].state = FINISHED;
            }
            else {
              worker[i].eating_count++;
            }
          }
        }
      }
    }
  }

  timer++;
  for (int i=0;i<MAX_TASK;i++) {
    if (task[i].state == FINISHED) {
      flag = 1;
    } 
    else {
      flag = 0;
    }
  }
}


class Dot{
  PVector pos;
  PVector vel;
  PVector acc;
  Brain brain;
  
  boolean dead = false;
  boolean reachedTarget = false;
  boolean isBest = false;
  
  float fitness = 0;
  
  Dot(){
    brain = new Brain(1000);
    pos = new PVector(width / 2, height - 10);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
  }
  
  void show(){
    if(isBest){
      fill(0, 255, 0);
      ellipse(pos.x, pos.y, 8, 8);
    }
    else{
      fill(0);
      ellipse(pos.x, pos.y, 4, 4);
    }
  }
  
  void update(){
    if(!dead && !reachedTarget){
      move();
      if(pos.x < 2 || pos.y < 2 || pos.x > width - 2 || pos.y > height - 2){
        dead = true;
      }
      else if(dist(pos.x, pos.y, target.x, target.y) < 10){
        reachedTarget = true;
      }
      else if((pos.x < 400 && pos.y < 160 && pos.x > 0 && pos.y > 150) || (pos.x < 600 && pos.y < 310 && pos.x > 200 && pos.y > 300) || (pos.x < 400 && pos.y < 460 && pos.x > 0 && pos.y > 450)){
        dead = true;
      }
    }
  }
  
  void move(){
    if(brain.directions.length > brain.step){
      acc = brain.directions[brain.step];
      brain.step++;
    }
    else{
      dead = true;
    }
    
    vel.add(acc);
    vel.limit(5);
    pos.add(vel);
  }
  
  void calculateFitness(){
    if(reachedTarget){
      fitness = 1.0 / 16.0 + 10000.0 / (float) (brain.step * brain.step);
    }
    else{
      float distToTarget = dist(pos.x, pos.y, target.x, target.y);
      fitness = 1.0 / (distToTarget * distToTarget);
    }
  }
  
  Dot reproduce(){
    Dot child = new Dot();
    child.brain = brain.clone();
    return child;
  }
}

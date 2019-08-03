class Population{
  Dot dots[];
  int gen = 1;
  float fitnessSum;
  int bestDot = 0;
  int minStep = 1000;
  int minStepDot = 1000;
  int deadDotNum = 0;
  int reachedDotNum = 0;
  
  Population(int size){
    dots = new Dot[size];
    for(int i = 0; i < size; i++){
      dots[i] = new Dot();
    }
  }
  
  int deadDots(){
    for(int i = 0; i < dots.length; i++){
      if(dots[i].dead){
        deadDotNum++;
      }
    }
    return deadDotNum;
  }
  
  int reachedDots(){
    for(int i = 0; i < dots.length; i++){
      if(dots[i].reachedTarget){
        reachedDotNum++;
      }
    }
    return reachedDotNum;
  }
  
  void show(){
    for(int i = 1; i < dots.length; i++){
      dots[i].show();
    }
    dots[0]. show();
  }
  
  void update(){
    for(int i = 0; i < dots.length; i++){
      if(dots[i].brain.step > minStep){
        dots[i].dead = true;
      }
      else{
        dots[i].update();
      }
    }
  }
  
  void calculateFitness(){
    for(int i = 0; i < dots.length; i++){
      dots[i].calculateFitness();
    }
  }
  
  void naturalSelection(){
    Dot newDots[] = new Dot[dots.length];
    setBestDot();
    calculateFitnessSum();
    
    newDots[0] = dots[bestDot].reproduce();
    newDots[0].isBest = true;
    for(int i = 1; i < newDots.length; i++){
      Dot parent = selectParent();
      newDots[i] = parent.reproduce();
    }
    dots = newDots.clone();
    gen++;
  }
  
  void setBestDot(){
    float max = 0;
    int maxIndex = 0;
    for(int i = 0; i < dots.length; i++){
      if(dots[i].fitness > max){
        max = dots[i].fitness;
        maxIndex = i;
      }
    }
    bestDot = maxIndex;
    if(dots[bestDot].reachedTarget){
      minStepDot = dots[bestDot].brain.step;
    }
  }
  
  void calculateFitnessSum(){
    fitnessSum = 0;
    for(int i = 0; i < dots.length; i++){
      fitnessSum += dots[i].fitness;
    }
  }
  
  Dot selectParent(){
    float rand = random(fitnessSum);
    float runningSum = 0;
    
    for(int i = 0; i < dots.length; i++){
      runningSum += dots[i].fitness;
      if(runningSum > rand){
        return dots[i];
      }
    }
    return null;
  }
  
  void makeBabiesXMen(){
    for(int i = 1; i < dots.length; i++){
      dots[i].brain.makeXMen();
    }
  }
}

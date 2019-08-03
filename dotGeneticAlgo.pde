PVector target = new PVector(300, 10);
int populationSize = 1000;
Population dotPopulation;

void setup(){
  size(600, 600);
  frameRate(60);
  dotPopulation = new Population(populationSize);
}

void draw(){
  background(255);
  
  fill(255, 0, 0);
  ellipse(target.x, target.y, 20, 20);
  
  fill(255, 255, 0);
  rect(0, 150, 400, 10);
  rect(200, 300, 600, 10);
  rect(0, 450, 400, 10);
  
  dotPopulation.deadDotNum = 0;
  dotPopulation.reachedDotNum = 0;
  int deadDots = dotPopulation.deadDots();
  int reachedDots = dotPopulation.reachedDots();
  
  if(deadDots + reachedDots == populationSize){
    dotPopulation.calculateFitness();
    dotPopulation.naturalSelection();
    dotPopulation.makeBabiesXMen();
  }
  else{
    dotPopulation.update();
    dotPopulation.show();
  }
  textSize(12);
  fill(0);
  text("Generation: " + dotPopulation.gen, 5, 12);
  text("Minimun steps: " + dotPopulation.minStepDot, 5, 24);
  text("Dots that reached the target: " + reachedDots, 5, 36);
}

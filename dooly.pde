import java.util.Iterator;
abstract class BodyPart{
  private float cx;
  private float cy;
  protected float S;
  protected BodyPart(float cx,float cy,float S){
      this.cx=cx;
      this.cy=cy;
      this.S=S;
  }
  protected void setCX(float cx){
    this.cx=cx;
  }
  protected void setCY(float cy){
    this.cy=cy;
  }
  protected float getCX(){
    return cx;
  }
  protected float getCY(){
    return cy;
  }
  public void move(float ax,float ay){
    setCX(getCX()+ax);
    setCY(getCY()+ay);
  }
  protected abstract void displaySelf();
  public void display(){
    displaySelf();
  }
}
final class Dooly extends BodyPart{
  float speed;
  public Dooly(float cx,float cy,float S){
    super(cx,cy,S);
    speed=random(1,3);
  }
  public boolean collided(){return this.getCY()+80*S>height;}
  protected void displaySelf(){
    fill(0x04,0xB4,0x31);
    ellipse(getCX(),getCY(),100*S,100*S);
    fill(255);
    ellipse(getCX(),getCY()+25*S,20*S,15*S);
    stroke(0);
    line(getCX()-20*S,getCY()-20*S,getCX()-30*S,getCY()-20*S);
    stroke(0);
    line(getCX()+20*S,getCY()-20*S,getCX()+30*S,getCY()-20*S);
    noStroke();
    fill(255);
    ellipse(getCX()-25*S,getCY(),25*S,30*S);
    fill(0);
    ellipse(getCX()-25*S,getCY(),10*S,15*S);
    fill(255);
    ellipse(getCX()+25*S,getCY(),25*S,30*S);
    fill(0);
    ellipse(getCX()+25*S,getCY(),10*S,15*S);
    fill(0x04,0xB4,0x31);
    ellipse(getCX()-28*S,getCY()+37*S,40*S,28*S);
    fill(0x04,0xB4,0x31);
    ellipse(getCX()+28*S,getCY()+37*S,40*S,28*S);
    fill(255,0,0);
    arc(getCX(),getCY()+48*S,25*S,25*S,0,PI);
  }
  public void idle(){
    if(this.collided()){
      speed=speed*-0.95;
        if(abs(speed)<=0.5) speed=0;
    }else{
      speed=speed+gravity;
    }
    this.move(0,speed);
  }
}
ArrayList<Dooly> doolies=new ArrayList();
float gravity=0.2;
float speed=0;
float y;
void setup(){
  size(1000,1000);
  noStroke();
  doolies.add(new Dooly(250,250,1.5));
}
void draw(){
  background(0);
  fill(255);
  textSize(32);
  text("Click to put head",100,100);
  text("use arrow keys to move around",0,200);
  Iterator<Dooly> iterator=doolies.iterator();
  while(iterator.hasNext()){
    Dooly dooly=iterator.next();
    dooly.display();
    dooly.idle();
  }
}
void mousePressed(){
  noLoop();
  speed=0;
  println(mouseX,mouseY);
  float S=random(0.1,3);
  gravity=random(0.01,3);
  doolies.add(new Dooly(mouseX,mouseY,S));
}
void mouseReleased(){
  loop();
}
void keyPressed(){
  Iterator<Dooly> iterator=doolies.iterator();
  while(iterator.hasNext()){
    Dooly dooly=iterator.next();
    if(key == CODED) {
      if(keyCode == UP) {
        dooly.move(0,-50);
      }else if(keyCode == DOWN) {
        dooly.move(0,50);
      }else if(keyCode==LEFT){
        dooly.move(-50,0);
      }else if(keyCode==RIGHT){
        dooly.move(50,0);
      }
    }
  }
}

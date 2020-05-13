void UIart()
{
  //upper line geometry
  ui.noFill();
  
  ui.strokeWeight(4);
  ui.stroke(paleGold);
  ui.beginShape();
  ui.vertex(2.5 * width/10, 2.5 * height /10);
  ui.vertex(7.5 * width/10, 2.5 * height/10);
  ui.endShape();
  
  ui.strokeWeight(4);
  ui.stroke(metalicGold);
  ui.beginShape();
  ui.vertex(0, 0);
  ui.vertex(0, 2.5 * height /10);
  ui.vertex(2.5 * width/10, 2.5 * height /10);
  ui.vertex(3.5 * width/10, 1.7* height/10);
  ui.vertex(6.5 * width/10, 1.7* height/10);
  ui.vertex(7.5 * width/10, 2.5 * height/10);
  ui.vertex(width, 2.5 * height/10);
  ui.vertex(width, 0);
  ui.vertex(0, 0);
  ui.endShape();
  
  
  ui.strokeWeight(10);
  ui.stroke(lightGold);
  ui.noFill();
  ui.beginShape();
  ui.vertex(0.01 * width, 0.01 * height);
  ui.vertex(0.01 * width, 2.45 * height /10);
  ui.vertex(2.45 * width/10, 2.45 * height /10);
  ui.vertex(3.45 * width/10, 1.65* height/10);
  ui.vertex(6.55 * width/10, 1.65* height/10);
  ui.vertex(7.55 * width/10, 2.45 * height/10);
  ui.vertex(0.99 * width, 2.45 * height/10);
  ui.vertex(0.99 * width, 0.01 * height);
  ui.vertex(0.01 * width, 0.01 * height);
  ui.endShape();
}

Board test;

void setup() {
  size(576, 1024);
<<<<<<< Updated upstream
  Board test = new Board(99);
  test.display();
  test.scoreCalc();
=======
  test = new Board(6);
>>>>>>> Stashed changes
}

void draw() {
  test.display();
}

// orb moving during board
void mousePressed() {
  if (mouseY >= 576) { // and if game started
    int row = (mouseY - 576) / 96;
    int col = mouseX / 96;
    println(row + ", " + col);
  }
}

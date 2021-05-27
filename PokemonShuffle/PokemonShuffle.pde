Board test;
int row;
int col;

void setup() {
  size(576, 1024);
  test = new Board(99);
  test.display();
}

void draw() {
  test.display();
}

// orb moving during board
void mousePressed() {
  if (mouseY >= 448) { // and if game started
    row = (mouseY - 448) / 96;
    col = mouseX / 96;
    println(row + ", " + col);
    test.getPokemon(row, col).toggleSelect();
  }
}

void mouseReleased() {
  if (mouseY >= 448) {
    test.getPokemon(row, col).toggleSelect();
  }
}

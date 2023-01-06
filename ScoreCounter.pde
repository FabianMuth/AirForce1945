class ScoreCounter {
  int xPos, yPos;
  int score = 0;
  int highscore = 0;
  Table scores;
  String fileName = "data\\scores.tsv";

  public ScoreCounter() {
    xPos = 10;
    yPos = 10;
    loadScoreTable();
    loadHighscore();
  }

  public ScoreCounter(int xPos, int yPos) {
    this();
    this.xPos = xPos;
    this.yPos = yPos;
  }

  void drawScore() {
    //current score
    textAlign(RIGHT);
    textSize(30);
    fill(0);
    text("Score: " + this.getScore(), width-width*0.01, 30);
    fill(255);
    text("Score: " + this.getScore(), width-width*0.01-1, 30-1);

    //highscore
    textSize(15);
    fill(0);
    text("Highscore: " + highscore, width-width*0.01, 30*2);
    fill(255);
    text("Highscore: " + highscore, width-width*0.01-1, 30*2-1);
  }

  void saveScore() {
    println("saving score");
    TableRow newRow = scores.addRow();
    //println(scores.getRowCount());
    newRow.setInt("id", scores.getRowCount()-1);
    newRow.setString("name", "player_" + str(scores.getRowCount()-1));
    newRow.setInt("score", score);
    saveTable(scores, fileName);
  }

  void loadScoreTable() {
    println("loading score table");
    if (loadTable(fileName) == null) {
      scores = new Table();
      scores.addColumn("id", Table.INT);
      scores.addColumn("name", Table.STRING);
      scores.addColumn("score", Table.INT);
    } else scores = loadTable(fileName, "header");
  }

  void loadHighscore() {
    println("loading highscore");
    int scr = 0;
    for (TableRow row : scores.rows()) {
      //println("scores: " + row.getColumnTitle(0));
      //println("id: " + row.getInt("id"));
      scr = row.getInt("score");
      if (highscore < scr) highscore = scr;
    }
    //println("highscore" + highscore);
  }

  void addScore(int score) {
    this.score += score;
  }

  void reset() {
    this.score = 0;
  }

  int getScore() {
    return score;
  }

  float getxPos() {
    return xPos;
  }

  float getyPos() {
    return yPos;
  }
}

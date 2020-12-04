package main

import (
  "bufio"
  "fmt"
  "os"
  "io"
)

const TREE_CHAR byte = '#'

func check(e error) {
  if e != nil && e != io.EOF {
      panic(e)
  }
}

func traverse(file io.Reader, xInc int, yInc int) int {
  reader := bufio.NewReader(file)

  xPos := 0
  yPos := 0

  trees := 0
  for {
    line, err := reader.ReadString('\n')
    check(err)

    if yPos % yInc == 0 {
      if line[xPos] == TREE_CHAR {
        trees += 1;
      }
      xPos = (xPos + xInc) % (len(line)-1)
    }
    yPos += 1

    if err == io.EOF {
        break
    }
  }

  return trees
}

func main() {
  filepath := os.Args[1]

  file, err := os.Open(filepath)
  check(err)

  vecs := [5][2]int{{1, 1}, {3, 1}, {5, 1}, {7, 1}, {1, 2}}

  value := 1
  for i := 0; i < len(vecs); i++ {
    v := traverse(file, vecs[i][0], vecs[i][1])
    value *= v
    file.Seek(0, 0)
  }

  fmt.Println(value)
}

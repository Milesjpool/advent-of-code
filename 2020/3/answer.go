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

func main() {
  filepath := os.Args[1]

  file, err := os.Open(filepath)
  check(err)

  reader := bufio.NewReader(file)

  X_inc := 3
  Y_inc := 1
  Y_pos := -Y_inc
  X_pos := -X_inc

  var line string
  trees := 0
  for {
    line, err = reader.ReadString('\n')
    check(err)

    Y_pos = Y_pos + Y_inc

    X_pos = (X_pos + X_inc) % (len(line)-1)

    if line[X_pos] == TREE_CHAR {
      trees += 1;
    }

    if err == io.EOF {
        break
    }
  }

  fmt.Println(trees)
}

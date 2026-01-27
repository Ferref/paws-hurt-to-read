import { Component, signal } from '@angular/core';
import { Tale } from '../models/tale.model'; 
import { Background } from '../background/background';

@Component({
  selector: 'app-home',
  imports: [Background],
  templateUrl: './home.html',
  styleUrl: './home.scss',
})
export class Home {
  title = signal("Welcome fellow reader. Read some interesting tales below");
  tales: Tale[] = [
    { id: 1, name: "Goal", value: "We'll analyze you! I mean the books you're reading :)" },
    { id: 2, name: "Number of books", value: "We currently have 999 books waiting to be read."},
    { id: 3, name: "Import", value: "Did you know? You can import your own books too."},
  ];
}

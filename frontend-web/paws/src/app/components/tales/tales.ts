import { Component } from '@angular/core';
import { Tale } from '../../models/tale.model'; 

@Component({
  selector: 'app-tales',
  imports: [],
  templateUrl: './tales.html',
  styleUrl: './tales.scss',
})
export class Tales {
  tales: Tale[] = [
    { id: 1, name: "Goal......", value: "We'll analyze you! I mean the books you're reading :)" },
    { id: 2, name: "Library...", value: "We currently have 999 books waiting to be read......."},
    { id: 3, name: "Import.....", value: "Did you know? You can import your own books too......"},
    { id: 4, name: "Platforms..", value: "[Android] => get it form the cat"},
  ];
}

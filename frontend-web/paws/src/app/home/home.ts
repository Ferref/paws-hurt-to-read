import { Component, signal } from '@angular/core';
import { Background } from '../background/background';
import { Tales } from '../components/tales/tales';
import { Cat } from '../components/cat/cat';

@Component({
  selector: 'app-home',
  imports: [Background, Tales, Cat],
  templateUrl: './home.html',
  styleUrl: './home.scss',
})
export class Home {
  title = signal("Welcome fellow reader. Read some interesting tales below");
}

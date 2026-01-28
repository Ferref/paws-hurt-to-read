import { Component, signal } from '@angular/core';
import { Background } from '../background/background';
import { Tales } from '../components/tales/tales';

@Component({
  selector: 'app-home',
  imports: [Background, Tales],
  templateUrl: './home.html',
  styleUrl: './home.scss',
})
export class Home {
  title = signal("Welcome fellow reader. Read some interesting tales below");
}

import { Component } from '@angular/core';
import { Particles } from '../components/particles/particles';

@Component({
  selector: 'app-background',
  standalone: true,
  imports: [Particles],
  templateUrl: './background.html',
  styleUrl: './background.scss',
})

export class Background {}

import { Component, signal } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';
import { faPaw } from '@fortawesome/free-solid-svg-icons';
import { Header } from './components/header/header';

@Component({
  selector: 'app-root',
  imports: [RouterOutlet, FontAwesomeModule, Header],
  templateUrl: './app.html',
  styleUrl: './app.scss'
})
export class App {
  favicon = faPaw;
}

import { Component, OnInit } from '@angular/core';
import { NgxParticlesModule, NgParticlesService } from '@tsparticles/angular';
import { MoveDirection, OutMode } from '@tsparticles/engine';
import { loadFull } from 'tsparticles';

@Component({
  selector: 'app-particles',
  standalone: true,
  imports: [NgxParticlesModule],
  templateUrl: './particles.html'
})
export class Particles implements OnInit {

  id = 'tsparticles';

  particlesOptions = {
    background: {
      color: { value: '#23023fff' }
    },
    fpsLimit: 144,
    interactivity: {
      events: {
        onClick: { enable: true, mode: 'push' },
        onHover: { enable: true, mode: 'grab' }
      },
      modes: {
        push: { quantity: 3 },
        grab: {
          distance: 200,
          links: { opacity: 1 }
        }
      }
    },
    particles: {
      color: {
        value: ['#00ffff', '#ff00ff', '#39ff14', '#ffea00', '#ff0055'],
        animation: {
          enable: true,
          speed: 20,
          sync: false
        }
      },
      shadow: {
        enable: true,
        blur: 15,
        color: '#00ffff'
      },
      links: {
        enable: true,
        distance: 130,
        color: 'random',
        opacity: 0.7,
        width: 1.5
      },
      move: {
        enable: true,
        speed: 3,
        direction: MoveDirection.none,
        random: true,
        outModes: { default: OutMode.bounce }
      },
      number: {
        density: { enable: true, area: 700 },
        value: 100
      },
      opacity: {
        value: 0.9,
        animation: {
          enable: true,
          speed: 1,
          minimumValue: 0.3
        }
      },
      shape: {
        type: 'circle'
      },
      size: {
        value: { min: 2, max: 6 },
        animation: {
          enable: true,
          speed: 4,
          minimumValue: 1
        }
      }
    },
    detectRetina: true
  };

  constructor(private ngParticlesService: NgParticlesService) {}

  ngOnInit() {
    this.ngParticlesService.init(async engine => {
      await loadFull(engine);
    });
  }

  particlesLoaded(container: any) {
    console.log(container);
  }
}
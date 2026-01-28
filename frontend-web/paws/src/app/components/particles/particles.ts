import { Component, OnInit } from '@angular/core';
import { NgxParticlesModule, NgParticlesService } from '@tsparticles/angular';
import { MoveDirection, OutMode } from '@tsparticles/engine';
import { loadFull } from 'tsparticles';
import { Inject, Injectable } from '@angular/core';

@Component({
  selector: 'app-particles',
  standalone: true,
  imports: [NgxParticlesModule],
  templateUrl: './particles.html'
})

export class Particles implements OnInit {

  id = 'tsparticles';

  // particlesUrl = 'http://foo.bar/particles.json';

  particlesOptions = {
    background: {
      color: { value: '#180b1bff' }
    },
    fpsLimit: 144,
    interactivity: {
      events: {
        onClick: { enable: true, mode: 'push' },
        onHover: { enable: true, mode: 'repulse' },
      },
      modes: {
        push: { quantity: 4 },
        repulse: { distance: 50, duration: 0.4 }
      }
    },
    particles: {
      color: { value: '#ffffff' },
      links: {
        color: '#ffffff',
        distance: 150,
        enable: true,
        opacity: 0.5,
        width: 1
      },
      move: {
        direction: MoveDirection.none,
        enable: true,
        outModes: { default: OutMode.split },
        random: false,
        speed: 2,
        straight: false
      },
      number: {
        density: { enable: true, area: 800 },
        value: 80
      },
      opacity: { value: 0.5 },
      shape: { type: 'square' },
      size: { value: { min: 1, max: 5 } }
    },
    detectRetina: true
  };

  constructor(private ngParticlesService: NgParticlesService) { }

  ngOnInit() {
    this.ngParticlesService.init(async (engine) => {
      await loadFull(engine);
    });
  }

  particlesLoaded(container: any) {
    console.log(container);
  }
}

import { ComponentFixture, TestBed } from '@angular/core/testing';

import { Tales } from './tales';

describe('Tales', () => {
  let component: Tales;
  let fixture: ComponentFixture<Tales>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [Tales]
    })
    .compileComponents();

    fixture = TestBed.createComponent(Tales);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

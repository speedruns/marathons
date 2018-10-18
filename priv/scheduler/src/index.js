import { h, render, Component } from 'preact';
import Scheduler from './components/scheduler';

// render an instance of Scheduler into <body>:
function init(callback) {
  fetch('/api/organizer/runs', {
    credentials: "same-origin"
  })
    .then((response) => response.json())
    .then((data) => callback(data))
    .catch((error) => console.log(error));
};

init((runs) => {
  const schedulerContainer = document.querySelector('#scheduler-container');

  const eventStart = new Date("2018-11-17T23:00:00");

  return render(<Scheduler runs={runs} startTime={eventStart} />, schedulerContainer);
});

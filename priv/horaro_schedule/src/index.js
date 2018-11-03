import { h, render, Component } from 'preact';
import HoraroSchedule from './components/horaro_schedule';

function init(scheduleData, container) {
  return render(<HoraroSchedule data={scheduleData.data} />, container);
}

const container = document.querySelector('#horaro_schedule_container');
const scheduleID = container.dataset.scheduleId;

fetch(`/api/horaro/schedule/${scheduleID}`)
  .then((response) => response.json())
  .then((data) => init(data, container))
  .catch((error) => console.log(error));


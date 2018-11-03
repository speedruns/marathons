function fetchSchedule(scheduleID) {
  fetch(`https://horaro.org/-/api/v1/schedules/${scheduleID}`)
    .then((response) => response.json())
    .then((data) => callback(data))
    .catch((error) => console.log(error));
}

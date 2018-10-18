function fetchRuns(callback) {
  fetch('/api/organizer/runs', {
    credentials: "same-origin"
  })
    .then((response) => response.json())
    .then((data) => callback(data))
    .catch((error) => console.log(error));
}

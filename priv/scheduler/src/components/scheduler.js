import { h, Component } from 'preact';
// import Dragula from 'react-dragula';

import Run from './run';
import RunSlot from './run-slot';

import { uniqueID } from '../util';


class Scheduler extends Component {
  constructor() {
    super();

    this.state = {
      scheduleEntries: []
    };
  }


  addScheduleEntry(type) {
    this.setState({
      scheduleEntries: this.state.scheduleEntries.concat({
        id: uniqueID(),
        type: type,
        runs: [],
        duration: 0
      })
    });
  }

  updateEntryInSlot(slotIndex, newEntry) {
    const newEntries = this.state.scheduleEntries.map((entry, index) => {
      return index == slotIndex ? newEntry : entry;
    });

    this.setState({
      scheduleEntries: newEntries
    });
  }

  removeScheduleEntry(slotIndex) {
    const {scheduleEntries} = this.state;
    console.log(slotIndex);
    this.setState({
      scheduleEntries: scheduleEntries.filter((_, i) => i !== slotIndex)
    });
  }

  startTimeForEntry(index) {
    const {startTime} = this.props;
    const {scheduleEntries} = this.state;

    const entryStartTime = new Date(startTime);
    for(let i = 0; i < index; i++) {
      entryStartTime.setMilliseconds(scheduleEntries[i].duration);
    }

    return entryStartTime;
  }


  render({startTime, runs}, {scheduleEntries}) {
    const runsById = runs.reduce((acc, run) => {
      acc[run.id] = run;
      return acc;
    }, {});

    const availableRuns = runs.filter((run) => {
      return !scheduleEntries.some((entry) => {
        return entry.runs.includes(run)
      })
    });

    return (
      <div class="scheduler">
        <div class="content">
          <p>Drag runs from the left to the timeline on the right to create a schedule. Create races by dragging a run on top of another run on the right.</p>

          <p>While creating a schedule, try to keep in mind the runners' time zones and general availability. If you aren't sure about someone's availability, it's better to ask <i>before</i> finalizing your schedule to avoid rescheduling issues later on.</p>

          <div class="field is-grouped">
            <div class="control">
              <button class="button is-primary">Save</button>
            </div>
          </div>
        </div>

        <div class="columns">
          <div class="column is-one-third">
            <h1 class="title is-4">Unscheduled Runs</h1>
            { availableRuns.map((run) => <Run run={run} />) }
          </div>

          <div class="column is-two-thirds">
            <h2 class="title is-4">Schedule</h2>

            <div class="schedule-container">
              {
                scheduleEntries.map((entry, index) => {
                  return (
                    <div class="schedule-entry">
                      <div class="schedule-entry__time">
                        {this.startTimeForEntry(index).toLocaleString()}
                      </div>

                      <div class="schedule-entry__slot">
                        <RunSlot
                          key={entry.id}
                          availableRuns={availableRuns}
                          entry={entry}
                          onChange={this.updateEntryInSlot.bind(this, index)}
                          onRemove={this.removeScheduleEntry.bind(this, index)}
                        />
                      </div>
                    </div>
                  );
                })
              }

              <div class="columns">
                <div class="column">
                  <div class="button is-primary is-fullwidth" onClick={this.addScheduleEntry.bind(this, "run")}>
                    Add Run
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    );
  }
}

export default Scheduler;

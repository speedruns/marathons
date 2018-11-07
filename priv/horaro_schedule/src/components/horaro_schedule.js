import { h, Component } from 'preact';
import { formatTime } from '../util';

class HoraroSchedule extends Component {
  getItemField(column, item, columns) {
    return item.data[columns.indexOf(column)];
  }

  render({data}) {
    const {name, link, columns, items} = data;
    let lastDate = -1;

    return (
      <div class="horaro-schedule">
        <div class="content">
          <p>
            The full schedule for this year's event is now live! Times shown below are in your current time zone. You can also <a class="has-text-gray-2" href={link} target="_blank" rel="noreferrer noopener">view this schedule on Horaro.</a>
          </p>
        </div>

        {
          items.map((item) => {
            const game = this.getItemField("Game", item, columns);
            const category = this.getItemField("Category", item, columns);
            const runners = this.getItemField("Runners", item, columns);
            const isRace = this.getItemField("Race?", item, columns);
            const startTime = new Date(item.scheduled);
            const estimate = item.length_t;

            const isNewDate = (startTime.getDate() != lastDate);
            lastDate = startTime.getDate();

            return (
              <div>
                { isNewDate &&
                  <div class="columns horaro-schedule__date-row">
                    {startTime.toLocaleDateString()}
                  </div>
                }
                <div class="columns is-mobile horaro-schedule-entry">
                  <div class="column is-3">
                    <span class="horaro-schedule-entry__start-time">{startTime.toLocaleTimeString()}</span>
                  </div>
                  <div class="column">
                    <span class="horaro-schedule-entry__game">{game}</span>
                    <span class="horaro-schedule-entry__category">{category}</span>
                  </div>
                  <div class="column">
                    <span class="horaro-schedule-entry__runners">{runners}</span>
                    <span class="horaro-schedule-entry__estimate">{formatTime(estimate, true)}</span>
                  </div>
                </div>
              </div>
            );
          })
        }
      </div>
    );
  }
}

export default HoraroSchedule;

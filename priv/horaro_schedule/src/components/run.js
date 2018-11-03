import { h, Component } from 'preact';
import { formatTime } from '../util';

class Run extends Component {
  render({run, children}, _state) {
    const {game, category, runner} = run;

    return (
      <div class="run">
        <div class="columns">
          <div class="column">
            <div class="is-pulled-right">
              <p class="time estimate"><strong>EST: { formatTime(run.estimate) }</strong></p>
              <p class="time pb">PB: { formatTime(run.pb) }</p>
            </div>
            <p class="game-name">{game.name}</p>
            <p>
              <span class="category-name">{category.name}</span> &mdash; <span class="runner-name">{runner.name}</span>
            </p>
          </div>

          { children.length > 0 &&
            <div class="column is-narrow">
              {children}
            </div>
          }
        </div>
      </div>
    );
  }
}

export default Run;

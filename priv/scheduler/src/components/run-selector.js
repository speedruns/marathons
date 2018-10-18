import { h, Component } from 'preact';
import Dragula from 'react-dragula';

import Run from './run';
import { fuzzysearch } from '../util';


class RunSelector extends Component {
  constructor() {
    super();

    this.state = {
      runFilter: null
    };
  }

  updateRunFilter(ev) {
    const input = ev.target;
    const filterText = input.value;

    this.setState({runFilter: filterText});
  }

  filteredRuns(runs) {
    const {runFilter} = this.state;
    const text = runFilter;


    if(!text || text == "") return runs;

    return runs.filter((run) => {
      return  fuzzysearch(text, run.game.name) ||
              fuzzysearch(text, run.category.name) ||
              fuzzysearch(text, run.runner.name);
    })
  };

  render(props, state) {
    const {runs, onSelect} = props;

    return(
      <div class="run-selector">
        <div class="field">
          <div class="control">
            <input class="input" type="text" onKeyUp={this.updateRunFilter.bind(this)} placeholder="Filter runs" />
          </div>
        </div>
        {
          this.filteredRuns(runs).map((run) =>
            <Run key={run.id} run={run}>
              <strong class="button" onClick={() => onSelect(run)}>+</strong>
            </Run>
          )
        }
      </div>
    );
  }
};

export default RunSelector;

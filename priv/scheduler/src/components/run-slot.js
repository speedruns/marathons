import { h, Component } from 'preact';
import Dragula from 'react-dragula';

import Run from './run';
import RunSelector from './run-selector';


class RunSlot extends Component {
  constructor() {
    super();

    this.state = {
      active: false,
      selectedRun: null
    };
  }

  toggleActivated() {
    this.setState({
      active: !this.state.active
    });
  }

  selectRun(run) {
    const {onChange, entry} = this.props;

    this.setState({
      active: false,
      selectedRun: run
    });

    onChange({
      ...entry,
      type: "run",
      runs: [run],
      duration: run.estimate
    });
  }

  removeSlot() {
    const {onRemove} = this.props;

    onRemove();
  }

  clear() {
    const {onChange, entry} = this.props;

    this.setState({
      selectedRun: null
    });

    onChange({
      ...entry,
      type: "run",
      runs: [],
      duration: 0
    });
  }

  render({availableRuns, entry}, {selectedRun, active}) {
    let slotClassList = 'run-slot';
    if(!selectedRun) slotClassList += ' run-slot--empty';

    return(
      <div class={slotClassList}>
        { selectedRun
            ? <Run run={selectedRun}>
                <strong class="button" onClick={this.clear.bind(this)}>
                  x
                </strong>
              </Run>
            : <div class="run-slot__empty">
                <div class="level">
                  <div class="level-left">
                    <div class="level-item" onClick={this.toggleActivated.bind(this)}>
                      { active
                        ? <span class="button is-outlined">Hide Selector</span>
                        : <span class="button is-outlined">Select a Run</span>
                      }
                    </div>
                  </div>

                  <div class="level-right">
                    <div class="level-item" onClick={this.removeSlot.bind(this)}>
                      <span class="button is-outlined">Remove slot</span>
                    </div>
                  </div>
                </div>
              </div>
        }

        { active &&
          <RunSelector runs={availableRuns} onSelect={this.selectRun.bind(this)} />
        }
      </div>
    );
  }
};

export default RunSlot;

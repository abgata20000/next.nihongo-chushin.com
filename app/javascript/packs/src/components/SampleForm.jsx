import React from 'react';

export default class SampleForm extends React.Component {

    constructor(props) {
        super(props);
        this.state = {
            text: ''
        };
        this.onChange = this.onChange.bind(this);
    }

    onChange(e) {
        this.setState({
            text: e.target.value
        });
    }

    render() {
        return (
            <div>
                <input type="text" onChange={this.onChange} value={this.state.text}/>
                <p>{this.state.text}</p>
            </div>
        );
    }

}

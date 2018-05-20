import React, {Component} from 'react'
import {postComment} from '../actions'
import {updateText} from '../actions'
import {resetText} from '../actions'

const changeText = (e, dispatch) => {
    dispatch(updateText(e.target.value));
};

const onKeypress = (e, dispatch, inputText) => {
    let ENTER = 13;
    if (e.which == ENTER) {
        if (e.nativeEvent.shiftKey) return;
        e.preventDefault();
        runPostComment(inputText, dispatch);
    }
};

const runPostComment = (text, dispatch) => {
    if(text.trim() == '') return;
    dispatch(postComment(text));
    dispatch(resetText());
};

class AddComment extends Component {
    constructor(props) {
        super(props);
    }

    componentDidMount() {
        console.log(this);
    }

    render() {
        return (
            <div>
            <textarea
                value={this.props.inputText}
                onChange={e => changeText(e, this.props.dispatch)}
                onKeyPress={e => onKeypress(e, this.props.dispatch, this.props.inputText)}
            />
                <button onClick={e => runPostComment(this.props.inputText, this.props.dispatch)}>
                    Add Comment
                </button>
            </div>
        )
    }
}

export default AddComment

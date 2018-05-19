import React from 'react'
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

const AddComment = ({inputText, dispatch}) => {
    let input;
    return (
        <div>
            <textarea
                value={inputText}
                onChange={e => changeText(e, dispatch)}
                onKeyPress={e => onKeypress(e, dispatch, inputText)}
            />
            <button onClick={e => runPostComment(inputText, dispatch)}>
                Add Comment
            </button>
        </div>
    )
};

export default AddComment

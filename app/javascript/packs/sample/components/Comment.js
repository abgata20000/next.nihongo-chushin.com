import React from 'react'
import PropTypes from 'prop-types'
import {setMention} from '../actions'

const click = (e, dispatch, name) => {
    e.preventDefault();
    dispatch(setMention(name));
};

const Comment = ({
    id, comment, icon, color, dispatch
}) =>
    (
        <li>
            {comment}
            <span>{id}</span>
            <button onClick={e => click(e, dispatch, id)}>
                button:{id}
            </button>
        </li>
    );

Comment.propTypes = {
    id: PropTypes.number.isRequired,
    comment: PropTypes.string.isRequired,
    icon: PropTypes.string,
    color: PropTypes.string,
};

export default Comment

import React from 'react'
import PropTypes from 'prop-types'
import {setMention} from '../actions'

const click = (e, dispatch, name) => {
    e.preventDefault();
    dispatch(setMention(name));
};

const Comment = ({
    id, user_id, room_id, comment, icon, color, nickname, system_message, created_at, dispatch
}) =>
    (
        <li>
            <div>
                {user_id}:{icon}:{nickname}:{color}
            </div>
            {comment}
            <span>{id}</span>
            <button onClick={e => click(e, dispatch, id)}>
                button:{id}
            </button>
            {created_at}
        </li>
    );

Comment.propTypes = {
    id: PropTypes.number.isRequired,
    user_id: PropTypes.number,
    room_id: PropTypes.number,
    comment: PropTypes.string.isRequired,
    icon: PropTypes.string,
    color: PropTypes.string,
    nickname: PropTypes.string,
    system_message: PropTypes.bool,
    created_at: PropTypes.string,
};

export default Comment

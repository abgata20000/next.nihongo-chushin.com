import { combineReducers } from 'redux'
import comments from './comments'
import inputText from './inputText'

export default combineReducers({
    comments,
    inputText
})

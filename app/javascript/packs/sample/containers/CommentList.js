import {connect} from 'react-redux'
import CommentList from '../components/CommentList'



const mapStateToProps = state => ({
    comments: state.comments
});

const mapDispatchToProps = dispatch => ({
});

export default connect(
    mapStateToProps,
    mapDispatchToProps
)(CommentList)

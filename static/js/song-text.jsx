var styles = require('./styles.js')

module.exports = React.createClass({
  displayName: "SongText",
  componentDidUpdate: function() {
    if(window.scrollY > 300) {
      window.scrollTo(0, 160);
    }
  },
  render: function() {
    if(this.props.currentsong != false) {
      var song = this.props.currentsong;
      return (
        <div className="col s12 l5 push-l7" style={styles.song}>
          <a href="#" style={styles.close}>
            <i className="material-icons"  onClick={this.props.onClose}>add</i>
          </a>
          <h3 style={styles.songtitle} dangerouslySetInnerHTML={{__html: song.songtitle}}></h3>
          <p style={styles.songmeta} dangerouslySetInnerHTML={{__html: song.songmeta}}></p>
          <p style={styles.songtext} dangerouslySetInnerHTML={{__html: song.songtext}}></p>
          <p style={styles.songmeta} dangerouslySetInnerHTML={{__html: song.songnotes}}></p>
        </div>
      );
    }
    else return false;
  }
});

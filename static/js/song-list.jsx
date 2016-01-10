var styles = require('./styles.js')

var SongListItem = require('./song-list-item.jsx')

module.exports = React.createClass({
  displayName: "SongList",
  render: function() {
    var songs = this.props.songs.map(function(song) {
      return (
        <SongListItem
          key={song.songid}
          songid={song.songid}
          songtitle={song.songtitle}
          checked={this.props.selected.indexOf(song.songid) != -1} // TODO: this is kinda ugly
          onClick={this.props.onSongClick}
          onSelectedChange={this.props.onSelectedChange} />
      );
    }.bind(this));
    var largewidth = this.props.currentsong ? "l7 pull-l5" : "l12"
    return (
      <div className={"collection col s12 " + largewidth}>
        {songs}
      </div>
    );
  }
});

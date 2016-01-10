var styles = require('./styles.js')

var SongList = require('./song-list.jsx')
var SongText = require('./song-text.jsx')

module.exports = React.createClass({
  displayName: "SongApp",
  fuse: {},
  getInitialState: function() {
    return {currentsong: false, songs: [], selected: []};
  },
  componentDidMount: function() {
    $.getJSON("/songs", function(data){
      var options = {
        caseSensitive: false,
        includeScore: false,
        shouldSort: true,
        threshold: 0.6,
        location: 0,
        distance: 50,
        maxPatternLength: 32,
        keys: ["songtitle","firstline"]
      };
      this.fuse = new Fuse(data.songs, options);
      this.setState({songs: this.fuse.list});
      this.setState({currentsong: this.getSong(location.hash.substr(1))})
    }.bind(this));
    window.addEventListener("hashchange", function() {
      this.setState({currentsong: this.getSong(location.hash.substr(1))})
    }.bind(this));
  },
  handleSelectedChange: function(checked, songid) {
    var newselected;
    if(checked) newselected = this.state.selected.concat([songid]);
    else        newselected = this.state.selected.filter(item => item != songid);
    this.setState({selected: newselected})

    var link = "songs.pdf?songids=" + Array.from(newselected);
    this.refs.PDFLink.href = link;
  },
  handleSongClick: function(songid) {
    this.setState({currentsong: this.getSong(songid)});
  },
  handleSongOverlayClose: function() {
    this.setState({currentsong: false});
    location.hash = "";
  },
  handleSearchChange: function(e) {
    if(e.target.value.length > 0) this.setState({songs: this.search(e.target.value)});
    else                          this.setState({songs: this.fuse.list});
  },
  handleSubmit: function(e) {
    e.preventDefault();
    var topsong = this.state.songs[0];
    this.setState({currentsong: topsong});
    location.hash = topsong.songid;
  },
  search: function(searchstring) {
    if(searchstring.length > 0) return this.fuse.search(searchstring);
    else                        return this.fuse.list;
  },
  getSong: function(songid) {
    songid = parseInt(songid);
    var filter = this.fuse.list.filter(song => song.songid === songid) // TODO: this is really ugly
    if(filter.length > 0)
      return filter[0];
    else
      return false;
  },
  render: function() {
    var disabled = this.state.selected.length < 1 ? " disabled" : "";
    return (
      <div>
        <div style={styles.header} className="valign-wrapper deep-orange lighten-1">
          <div style={styles.centered}>
            <h3 className="valign" style={styles.headertext}>/dev/audio</h3>
            <a ref="PDFLink" target="_blank"
               style={styles.mainbutton}
               className={"btn deep-orange darken-1" + disabled}>
              PDF
            </a>
          </div>
        </div>
        <form onSubmit={this.handleSubmit} style={styles.centered}>
          <input
            style={styles.searchbar}
            type="text"
            autoFocus
            placeholder="Song title or firstline"
            onChange={this.handleSearchChange} />
        </form>
        <div className="row" style={styles.centered}>
          <SongText
            currentsong={this.state.currentsong}
            onClose={this.handleSongOverlayClose} />
          <SongList
            songs={this.state.songs}
            selected={this.state.selected}
            currentsong={this.state.currentsong != false}
            onSongClick={this.handleSongClick}
            onSelectedChange={this.handleSelectedChange} />
        </div>
      </div>
    );
  }
});

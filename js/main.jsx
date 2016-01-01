var Song = React.createClass({
  handleCheckboxClick: function(e) {
    this.props.onSelectedChange(e.target.checked, this.props.songid);
  },
  handleSongClick: function(e) {
    this.props.onClick(this.props.songid);
  },
  render: function() {
    return (
      <div className="collection-item">
        <a href={"#" + this.props.songid} onClick={this.handleSongClick}>
          {this.props.songtitle}
        </a>
        <div style={styles.checkbox}>
            <input
              type="checkbox"
              id={"song" + this.props.songid}
              defaultChecked={this.props.checked}
              onChange={this.handleCheckboxClick} />
          <label htmlFor={"song" + this.props.songid} />
        </div>
      </div>
    );
  }
});

var SongList = React.createClass({
  render: function() {
    var songs = this.props.songs.map(function(song) {
      return (
        <Song 
          key={song.songid}
          songid={song.songid}
          songtitle={song.songtitle}
          checked={this.props.selected.indexOf(song.songid) != -1} // TODO: this is kinda ugly
          onClick={this.props.onSongClick}
          onSelectedChange={this.props.onSelectedChange} />
      );
    }.bind(this));
    return (
      <div className="collection">
        {songs}
      </div>
    );
  }
});

var SongOverlay = React.createClass({
  render: function() {
    if(this.props.allSongs.hasOwnProperty(this.props.currentsong)) {
      var song = this.props.allSongs.filter(song => song.songid == this.props.currentsong)[0]; // TODO: this is really ugly
      return (
        <div id="overlay" style={styles.songoverlay}>
          <a href="#" style={styles.close}>
            <i className="material-icons"  onClick={this.props.onClose}>add</i>
          </a>
          <h3 style={styles.songtitle} dangerouslySetInnerHTML={{__html: song.songtitle}}></h3>
          <p style={styles.songtext} dangerouslySetInnerHTML={{__html: song.songtext}}></p>
          <p style={styles.songmeta} dangerouslySetInnerHTML={{__html: song.songmeta}}></p>
          <p style={styles.songmeta} dangerouslySetInnerHTML={{__html: song.songnotes}}></p>
        </div>
      );
    }
    else
      return false;
  }
});

var SearchApp = React.createClass({
  allSongs: [],
  fuse: {},
  getInitialState: function() {
    return {searchstring: '', currentsong: location.hash.substr(1), songs: [], selected: []};
  },
  componentDidMount: function() {
    $.getJSON('/songs', function(data){
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
      this.allSongs = data.songs;
      this.setState({songs: this.search()});
    }.bind(this));
    window.addEventListener("hashchange", function() {
      this.setState({currentsong: location.hash.substr(1)})
    }.bind(this));
  },
  handleSelectedChange: function(checked, songid) {
    var newstate;
    if(checked) newstate = this.state.selected.concat([songid]);
    else        newstate = this.state.selected.filter(item => item != songid);
    this.setState({selected: newstate})

    var link = 'songs.pdf?songids=' + Array.from(newstate);
    this.refs.PDFLink.href = link;
  },
  handleSongClick: function(songid) {
    this.setState({currentsong: songid})
  },
  handleSongOverlayClose: function() {
    this.setState({currentsong: false});
    location.hash = '';
  },
  handleSearchChange: function(e) {
    if(e.target.value.length > 0) this.setState({searchstring: e.target.value, songs: this.search()});
    else                          this.setState({searchstring: "", songs: this.fuse.list});
  },
  handleSubmit: function(e) {
    e.preventDefault();
    var topsongid = this.state.songs[0].songid;
    this.setState({currentsong: topsongid});
    location.hash = topsongid;
  },
  search: function() {
    if(this.state.searchstring.length > 0) return this.fuse.search(this.state.searchstring);
    else                                   return this.fuse.list;
  },
  render: function() {
    var disabled = this.state.selected.length < 1 ? ' disabled' : '';
    return (
      <div>
        <div style={styles.header} className="valign-wrapper deep-orange lighten-1">
          <div style={styles.centered}>
            <h3 className="valign" style={styles.headertext}>/dev/audio</h3>
            <a ref="PDFLink" target="_blank"
               style={styles.mainbutton}
               className={"btn deep-orange" + disabled}>
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
        <div style={styles.centered}>
          <SongList
            songs={this.state.songs}
            selected={this.state.selected}
            onSongClick={this.handleSongClick}
            onSelectedChange={this.handleSelectedChange} />
          <SongOverlay
            allSongs={this.allSongs}
            currentsong={this.state.currentsong}
            onClose={this.handleSongOverlayClose} />
        </div>
      </div>
    );
  }
});

ReactDOM.render(
  <SearchApp />,
  document.getElementById("wrapper")
);

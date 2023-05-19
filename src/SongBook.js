import {ReactComponent as Cover} from './assets/Omslag.svg';
import SongPage from './SongPage';

// The Main page of the site, containing the songpage as well as buttons
// to continue to the next or previous songs.
export const SongBook = ({ bookletList, allSongs, songIndex, setSongIndex, partitions, removeFromBooklet}) => {

    // Bools whether we are on any of the last pages
    var leftMostPage = songIndex === 0 || songIndex === -1
    var rightMostPage = songIndex === bookletList.length - 1

    const decrementIndex = () => {
        if(songIndex > 0){
            setSongIndex(songIndex - 1)
        }
    }

    const incrementIndex = () => {
        if(songIndex < bookletList.length - 1){
            setSongIndex(songIndex + 1)
        }
    }

    return (
        <div className='flex flex-col h-min'>
            <div className='text-white flex flex-row w-full flex-grow'>
                <button onClick={decrementIndex} disabled={leftMostPage} className="invisible w-0 h-0 landscape:visible bg-zinc-600 md:w-16 md:h-16 m-auto rounded-full hover:bg-zinc-500 disabled:hover:bg-zinc-800 disabled:bg-zinc-800 disabled:text-gray-500">
                    {"<"}
                </button>
                {
                bookletList.length == 0 || songIndex < 0 ?
                <Cover fill="#EE2A7B" className="max-w-[200pt] h-min p-4"/>
                :
                    <div className='flex flex-col'>
                        <SongPage song={allSongs[bookletList[songIndex]]} bookletIndex={songIndex} partitions={partitions} removeSong={removeFromBooklet}/>
                        <div className='align-center text-[#777777]'>
                            {`${songIndex + 1}/${bookletList.length}`}
                        </div>
                    </div>

                }
                <button onClick={incrementIndex} disabled={rightMostPage} className="invisible w-0 h-0 landscape:visible bg-zinc-600 md:w-16 md:h-16 m-auto rounded-full hover:bg-zinc-500 disabled:hover:bg-zinc-800 disabled:bg-zinc-800 disabled:text-gray-500">
                    {">"}
                </button>
            </div>
            <div className='landscape:invisible md:max-h-0 max-h-full flex-grow flex flex-row my-5 md:my-0 w-full text-white'>
                <button onClick={decrementIndex} disabled={leftMostPage} className="bg-zinc-600 w-16 h-16 m-auto rounded-full hover:bg-zinc-500 disabled:hover:bg-zinc-800 disabled:bg-zinc-800 disabled:text-gray-500">
                        {"<"}
                </button>

                <button onClick={incrementIndex} disabled={rightMostPage} className="bg-zinc-600 w-16 h-16 m-auto rounded-full hover:bg-zinc-500 disabled:hover:bg-zinc-800 disabled:bg-zinc-800 disabled:text-gray-500">
                        {">"}
                </button>

            </div>
        </div>
    )
}

export default SongBook

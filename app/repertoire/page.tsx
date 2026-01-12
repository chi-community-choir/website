import { getAllSongs } from '@/lib/songs'
import RepertoireClient from './RepertoireClient'

export default function RepertoirePage() {
  const songs = getAllSongs()

  return <RepertoireClient songs={songs} />
}

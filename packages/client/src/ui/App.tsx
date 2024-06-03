import { useEffect } from "react";
import { useStore } from "../store";
import { PhaserLayer } from "./PhaserLayer";
import { UIRoot } from "./UIRoot";
import { useNetworkLayer } from "./hooks/useNetworkLayer";

export const App = () => {
  const networkLayer = useNetworkLayer();

  useEffect(() => {
    if (networkLayer) {
      useStore.setState({ networkLayer });
    }

    const audioContext = new (window.AudioContext || window.AudioContext)();

    const resumeAudioContext = () => {
      if (audioContext.state !== 'running') {
        audioContext.resume();
      }
    };

    window.addEventListener('click', resumeAudioContext);

    return () => {
      window.removeEventListener('click', resumeAudioContext);
    };
  }, [networkLayer]);

  return (
    <div>
      <PhaserLayer networkLayer={networkLayer} />
      <UIRoot />
    </div>
  );
};

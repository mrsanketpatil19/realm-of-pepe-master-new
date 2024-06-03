import { createStore as createVanillaStore } from "zustand/vanilla";
import { create } from "zustand";
import { NetworkLayer } from "./layers/network/createNetworkLayer";
import { PhaserLayer } from "./layers/phaser/createPhaserLayer";

export type Store = {
  networkLayer: NetworkLayer | null;
  phaserLayer: PhaserLayer | null;
  devMode: boolean;
};

export type UIStore = {
  networkLayer: NetworkLayer;
  phaserLayer: PhaserLayer;
  devMode: boolean;
};

export const vanillaStore = createVanillaStore<Store>(() => ({
  networkLayer: null,
  phaserLayer: null,
  devMode: false,
}));

export const useStore = create(() => ({
  networkLayer: vanillaStore.getState().networkLayer,
  phaserLayer: vanillaStore.getState().phaserLayer,
  devMode: vanillaStore.getState().devMode,
  setNetworkLayer: (networkLayer: NetworkLayer) => vanillaStore.setState({ networkLayer }),
  setPhaserLayer: (phaserLayer: PhaserLayer) => vanillaStore.setState({ phaserLayer }),
  setDevMode: (devMode: boolean) => vanillaStore.setState({ devMode }),
}));

export const useMUD = () => {
  const networkLayer = useStore((state) => state.networkLayer);
  const phaserLayer = useStore((state) => state.phaserLayer);
  const devMode = useStore((state) => state.devMode);

  if (networkLayer === null || phaserLayer === null) {
    throw new Error("Store not initialized");
  }

  return {
    networkLayer,
    phaserLayer,
    devMode,
  } as UIStore;
};

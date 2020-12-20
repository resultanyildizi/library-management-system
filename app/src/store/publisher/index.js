import axios from "axios";
import slugify from "slugify";

const BASE_URL = "http://localhost:5000/api/publisher";
const state = {
  publishers: [],
};
const getters = {
  getPublishers: (state) => state.publishers,
  getPublishersMap: (state) => {
    if (state.publishers) {
      return state.publishers.reduce((map, obj) => {
        map[obj.publisherId] = `${obj.name} #${obj.publisherId}`;
        return map;
      }, {});
    }
  },
};
const actions = {
  bindPublishers: async ({ commit, dispatch }) => {
    try {
      const token = localStorage.getItem("token");
      const request = axios.get(BASE_URL, {
        headers: {
          "Content-Type": "application/json",
          Authorization: token,
        },
      });

      const result = await dispatch(
        "auth/validateAndResponse",
        { request },
        { root: true }
      );
      if (result && result.data)
        commit("setPublishers", { publishers: result.data });
    } catch (err) {
      console.log(err);
    }
  },
  addPublisher: async (
    { dispatch },
    { name, foundationYear, description, imageData }
  ) => {
    try {
      var image = null;
      const token = localStorage.getItem("token");
      if (imageData) {
        const fileName = `publisher/${slugify(
          name
        )}_${Date.now().toString()}.${imageData.name.split(".").pop()}`;

        image = await dispatch(
          "uploadImage",
          { imageData, fileName },
          { root: true }
        );
      }
      const request = axios.post(
        BASE_URL,
        {
          name,
          foundationYear,
          description,
          image,
        },
        {
          headers: {
            "Content-Type": "application/json",
            Authorization: token,
          },
        }
      );
      const result = await dispatch(
        "auth/validateAndResponse",
        { request },
        { root: true }
      );
      if (result && result.status === 201) {
        setInterval(() => {
          dispatch("bindPublishers");
        }, 1000);
      }
    } catch (err) {
      console.log(err);
    }
  },
};
const mutations = {
  setPublishers: (state, { publishers }) => (state.publishers = publishers),
};
export default { namespaced: true, state, getters, actions, mutations };

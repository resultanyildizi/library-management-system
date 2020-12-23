import axios from "axios";
import slugify from "slugify";
import router from "../../router";
const BASE_URL = "http://localhost:5000/api/bookInfo";
const UPDATE_AND_INSERT_URL = `${BASE_URL}/updateAndInsert`;
const UPDATE_CATEGORY_ID_URL = `${BASE_URL}/updateCategoryId`;
const UPDATE_SCORE_URL = `${BASE_URL}/updateScore`;

const state = {
  bookInfos: [],
  bookInfo: null,
  lastInsertedBookId: null,
  orderType: 1,
};

const getters = {
  getBookInfos: (state) => state.bookInfos,
  getBookInfo: (state) => state.bookInfo,
  getLastInsertedBookId: (state) => state.lastInsertedBookId,
  getOrderType: (state) => state.orderType,
};

const actions = {
  bindBookInfos: async ({ commit, dispatch, state }) => {
    try {
      const token = localStorage.getItem("token");
      const request = axios.get(BASE_URL, {
        params: {
          orderType: state.orderType,
        },
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
      if (result && result.data) commit("setBooks", { bookInfos: result.data });
    } catch (err) {
      router.push({ name: "Error", params: { error: err } });
    }
  },

  deleteBook: async ({ dispatch }, { bookInfoId }) => {
    try {
      const token = localStorage.getItem("token");

      const request = axios.delete(BASE_URL + `/${bookInfoId}`, {
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
      if (result && result.status >= 200 && result.status < 400)
        dispatch("bindBookInfos");
    } catch (err) {
      router.push({ name: "Error", params: { error: err } });
    }
  },

  addOrUpdateBook: async (
    { commit, dispatch },
    {
      bookInfoId,
      name,
      publishYear,
      edition,
      pageCount,
      height,
      width,
      imageData,
      languageId,
      description,
    }
  ) => {
    var image = null;
    const token = localStorage.getItem("token");
    if (imageData && imageData.size > 0) {
      const fileName = `book/${slugify(
        name
      )}_${Date.now().toString()}.${imageData.name.split(".").pop()}`;

      image = await dispatch(
        "uploadImage",
        { imageData, fileName },
        { root: true }
      );
    }

    if (imageData && imageData.size <= 0) {
      image = imageData.name;
    }

    console.log(image);

    const payload = {
      name,
      publishYear,
      edition,
      pageCount,
      height,
      width,
      image,
      languageId,
      description,
    };

    const config = {
      headers: {
        "Content-Type": "application/json",
        Authorization: token,
      },
    };

    const request = bookInfoId
      ? axios.put(BASE_URL + `/${bookInfoId}`, payload, config)
      : axios.post(BASE_URL, payload, config);

    const result = await dispatch(
      "auth/validateAndResponse",
      { request },
      { root: true }
    );
    if ((result && result.status === 201) || result.status === 200) {
      console.log(result.data.output);
      if (result.data && result.data.output && result.data.output.bookId) {
        commit("setLastInsertedBookId", {
          bookId: result.data.output.bookId,
        });

        dispatch("bindBookInfos");
      } else {
        commit("setLastInsertedBookId", { bookId: null });
      }
    }
  },

  updateAndInsert: async (
    { dispatch, state },
    { translatorId, publisherId, authorIdList }
  ) => {
    if (state.lastInsertedBookId) {
      const bookInfoId = state.lastInsertedBookId;
      const token = localStorage.getItem("token");
      const request = axios.put(
        `${UPDATE_AND_INSERT_URL}/${bookInfoId}`,
        {
          translatorId,
          publisherId,
          authorIdList,
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
        dispatch("bindBookInfos");
      }
    } else
      throw new Error(
        "bookInfoId is not valid. Probably there is an error with insert request"
      );
  },

  updateCategoryId: async ({ dispatch, state }, { categoryId }) => {
    if (state.lastInsertedBookId) {
      const bookInfoId = state.lastInsertedBookId;
      const token = localStorage.getItem("token");
      const request = axios.put(
        `${UPDATE_CATEGORY_ID_URL}/${bookInfoId}`,
        {
          categoryId,
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

      console.log(result);
      if (result && result.status >= 200 && result.status < 400) {
        dispatch("bindBookInfos");
      }
    } else
      throw new Error(
        "bookInfoId is not valid. Probably there is an error with insert request"
      );
  },

  updateScore: async ({ dispatch }, { bookInfoId, score }) => {
    const token = localStorage.getItem("token");
    const request = axios.put(
      `${UPDATE_SCORE_URL}/${bookInfoId}`,
      {
        score,
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

    if (result && result.status >= 200 && result.status < 400) {
      dispatch("bindBookInfos");
    }
  },

  openBookPage: ({ commit }, { bookInfo }) => {
    commit("setBook", { bookInfo });
    router.push({ name: "Book" });
  },

  changeOrderType: async ({ commit, dispatch }, { orderType }) => {
    commit("setOrderType", { orderType });
    await dispatch("bindBookInfos");
  },
};
const mutations = {
  setBooks: (state, { bookInfos }) => (state.bookInfos = bookInfos),
  setBook: (state, { bookInfo }) => (state.bookInfo = bookInfo),
  setOrderType: (state, { orderType }) => (state.orderType = orderType),
  setLastInsertedBookId: (state, { bookId }) =>
    (state.lastInsertedBookId = bookId),
};
export default { namespaced: true, state, getters, actions, mutations };

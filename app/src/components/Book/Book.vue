<template>
  <li style="transform: scale(0.8)">
    <figure class="book">
      <!-- Front -->

      <ul class="hardcover_front">
        <li>
          <img
            style="background-size: contain !important"
            :src="getImage"
            alt=""
            width="100%"
            height="100%"
          />
        </li>
        <li></li>
      </ul>

      <!-- Pages -->
      <ul class="page">
        <li></li>
        <li class="text-center pt-2">
          <span class="caption google-sans-regular primary--text"
            >{{ bookInfo.vpageCount }} pages</span
          >
          <br />
          <span class="caption google-sans-regular primary--text">{{
            bookInfo.categoryName
          }}</span>

          <v-divider class="my-2"></v-divider>
          <a :style="getVisibility" class="btn" @click="_updateBook">Update</a>
          <br />
          <a class="btn" @click="_openBook">Open</a>
          <br />
          <a :style="getVisibility" class="btn" @click="_deleteBook">Delete</a>
          <v-divider class="my-2"></v-divider>
          <div class="caption secondary--text">Score</div>
          <v-rating
            background-color="secondary "
            color="secondary"
            v-model="score"
            dense
            hover
            size="20"
          ></v-rating>
        </li>
        <li></li>
        <li></li>
        <li></li>
      </ul>

      <!-- Back -->

      <ul class="hardcover_back">
        <li></li>
        <li></li>
      </ul>
      <ul class="book_spine">
        <li></li>
        <li></li>
      </ul>
      <figcaption>
        <h1>{{ bookInfo.name }}</h1>
        <span>By {{ bookInfo.authorNames }}</span>
        <span class="append" v-if="bookInfo.translatorId">
          Translated by {{ bookInfo.translatorName }}
        </span>
        <span class="append mb-3"
          >Published by {{ bookInfo.publisherName }}</span
        >
        <p>{{ bookInfo.vdescription.substring(0, 250) }}...”</p>
      </figcaption>
    </figure>
  </li>
</template>

<script>
import { mapActions } from "vuex";
export default {
  name: "Book",
  data() {
    return {
      score: 0,
    };
  },

  created() {
    this.score = this.bookInfo.score;
  },

  watch: {
    score(newVal, oldVal) {
      if (newVal !== oldVal && newVal && oldVal) {
        this.updateScore({
          bookInfoId: this.bookInfo.bookInfoId,
          score: newVal,
        });
      }
    },
  },

  methods: {
    ...mapActions("book", ["deleteBook", "updateScore", "openBookPage"]),
    _updateBook() {
      console.log("Update");
      this.$emit("updateBookDialog", this.bookInfo);
    },
    async _deleteBook() {
      const { name, bookInfoId } = this.bookInfo;
      this.$emit("deleteBookDialog", { name, bookInfoId });
    },
    _openBook() {
      this.openBookPage({ bookInfo: this.bookInfo });
    },
  },

  computed: {
    getImage() {
      try {
        return require(`@/assets/upload/img/${this.bookInfo.vimage}`);
      } catch (err) {
        return require("@/assets/upload/img/book/default_book_cover.jpg");
      }
    },

    getVisibility() {
      return this.updateable ? "visibility: visible" : "visibility: hidden";
    },
  },
  props: {
    bookInfo: {
      type: Object,
      required: true,
    },
    updateable: {
      type: Boolean,
      required: true,
    },
  },
};
</script>

<style>
</style>